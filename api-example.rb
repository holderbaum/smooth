-#
  components/
    sec.haml   # <---- title=nil
    sec_notice.haml
    slide.haml
    slide_plain.haml
    text.haml

=about do
  =title    "API"
  =author   "J Holderbaum"
  =company  "Company"
  =email    "mail@daemon.com"
  =date     # defaults to DateTime.now
  =venue    "Interwebz"


=slides do
  =slide "hello world", :plain do
    =text do
      * iochdfksla
      * sfdsf
    =sec "section", :notice do
      Dies ist die Einleitung
    =sec do
      Nö, da fehlt nix
----



