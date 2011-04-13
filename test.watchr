#!/usr/bin/env watchr

NOTIFY = true
if ARGV[1] and ARGV[1] == "shell"
  NOTIFY = false
end

LIBNOTIFY_OPTIONS = {
  :green => {
    :icon_path => "/usr/share/icons/gnome/scalable/emblems/emblem-default.svg",
    :timeout => 0.5,
    :urgency => :normal,
    :summary => "PASS"
  },
  :red => {
    :icon_path => "/usr/share/icons/gnome/scalable/emotes/face-angry.svg",
    :timeout => 2.5,
    :urgency => :critical,
    :summary => "FAIL!"
  }
}

def notify(message)
  if NOTIFY
    require 'libnotify'

    color = message =~ /(.*0 failures, 0 errors.*)/ ? :green : :red

    Libnotify.show(LIBNOTIFY_OPTIONS[color]) do |notify|
      notify.body = color == :red ? message : $1
      notify.append = true
    end
  end
rescue LoadError => e
ensure
  #puts message
end

def run(cmd)
  puts(cmd)

  r, w = IO.pipe
  result = ""

  child = fork do
    STDOUT.reopen w
    w.close
    system cmd
  end
  w.close

  while char = r.read(1)
    print char
    STDOUT.flush
    result << char
  end

  result
end

def run_test_file(file)
  clear
  notify(run "ruby -rubygems -Ilib:test #{file}")
end

def run_tests
  clear
  notify(run "rake")
end

def clear
  system "clear"
end

def underscore(file)
  file.gsub('/', '_')
end

@interrupted = false

Signal.trap 'QUIT' do
  run_tests
end

Signal.trap 'INT' do
  if @interrupted then
    abort("\n")
  else
    puts "Interrupt a second time to quit"
    @interrupted = true
    Kernel.sleep 1.5
    # raise Interrupt, nil # let the run loop catch it
    run_tests
  end
end

run_tests

watch('test/.*_test\.rb') {|md| run_test_file md[0] }
watch('lib/smooth/(.*)\.rb') {|md| run_test_file "test/#{underscore(md[1])}_test.rb" }
watch('test/helper.rb') { run_tests }

