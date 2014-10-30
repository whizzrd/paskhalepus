MY = Makefile $(BASENAME).curlout $(BASENAME).curlrc $(BASENAME).netrc $(BASENAME).sha1
URL ?= linkblog.algorist.nl/users.rss
BASENAME ?= $(shell basename ${PWD})
SHA1 ?= $(BASENAME).sha1
3V0L ?= $(BASENAME).meta4
3M ?= $(BASENAME).finger
4ND ?= $(BASENAME).par2
D1S ?=$(BASENAME).zone
REPAIR ?= $(BASENAME).patch
LOOK ?= $(wildcard *.*)
WHO ?= $(BASENAME).netrc
TAIL ?= $(BASENAME).curltrace
QUID ?= $(SHA1) $(3V0L) $(3M) $(4ND) $(D1S) $(REPAIR)
PRO ?= $(filter-out $(QUID),$(LOOK))
QUO ?= $(VOID)

.PHONY : $(SHA1) all
.PRECIOUS : $(MY)

all : $(SHA1) $(3V0L) $(3M) $(4ND) $(D1S) $(REPAIR)

clean : 
	-rm $(TAIL) $(WHO) $(LOOK)

%.sha1 : $(wildcard *)
	shasum -p $(PRO) | tee $(SHA1) | xargs -n1 -I % echo * "$(URL)" $(shell date -ju)


%:
	@echo TODO: $@
	curl --user-agent "Mozilla/4.0 ($(shell uname -a)) $(BASENAME)/0xC0FF33" --head $(basename $@).$(patsubst $(basename $@).%,%,$@).$(BASENAME).$(shell dirname "$(URL)") 
	curl --user-agent "Mozilla/4.0 ($(shell uname -a)) $(BASENAME)/0xC0FF33"  --create-dirs --output $@ --remote-name --url $(basename $@).$(patsubst $(basename $@).%,%,$@).$(BASENAME).$(shell dirname "$(URL)")


arachnitpick :
	curl --write-out "%{local_ip} \"%{url_effective}\" %{http_code} \"%{content_type}\" \"%{filename_effective}\"\n" --silent --url "http://{artronics|algorist].nl/" --output #1.#2

sebastos :
	curl --config $(BASENAME).curlrc --write-out @$(BASENAME).curlout --silent --xattr --trace $(TAIL) --trace-time --netrc-file $(WHO)

