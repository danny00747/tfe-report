SRC_DIR = src
SRC     = $(wildcard $(SRC_DIR)/*.md)

OUT = report.pdf

FROM     = markdown
TO       = latex
METADATA = $(SRC_DIR)/01_metadata.yaml

WATCHED_FILES = $(METADATA) $(SRC)

PANDOC_IN = $(METADATA) $(SRC)

FLAGS =  --pdf-engine xelatex
FLAGS += --template eisvogel.tex 
FLAGS += --filter pandoc-latex-environment 
FLAGS += --citeproc
FLAGS += -N --listings

.PHONY: all watch open clean

all: $(OUT)

$(OUT): $(PANDOC_IN)
	@echo "Starting Pandoc ..."
	@pandoc $(PANDOC_IN) -f $(FROM) -t $(TO) -o $@ $(FLAGS)
	@echo "$(OUT) updated !"

watch:
	@echo $(WATCHED_FILES) | tr ' ' '\n' | \
	    entr -s 'notify-send -t 5000 "Compiling PDF" && \
            $(MAKE) --no-print-directory && \
            notify-send -t 5000 "Done" || \
            notify-send -t 5000 "Failed"'

open:
	zathura --fork $(OUT)

clean:
	rm $(OUT) $(CODE_MD)
