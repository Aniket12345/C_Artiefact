#####
# Makefile for CPP practice
#
# Developer: Jestin PJ and Aniket Fondekar 
#
# Date: 30 June 2023 
# -----usage------------ start
# make                   (build with default cpp standard 17)
# make clean
# make cpp14 / make cpp17 / make cpp20 /make cpp23
# make run
# make help
# make clean cpp14 run   (clean, build with cpp14 and run)
# make build
# -----usage------------ end
######

# Add author name Here
AUTHOR_NAME = "Aniket Fondekar"
#############################################################

COMPILED_DATE = $$(date +"%Y-%m-%d")

TARGET = main

SRC = src
INC = inc
BIN = bin
CC = gcc

RED = \033[1;31m
GREEN = \033[1;32m
BLUE = \033[1;34m
YELLOW = \033[1;33m
NC = \033[1;0m

CFLAGS = -Wall -I$(INC)

SOURCE = $(wildcard $(SRC)/*.c)

OBJECT = $(patsubst %,$(BIN)/%,$(filter %.o,$(notdir $(SOURCE:.c=.o))))

# Default target
all: build

	
build : clean $(BIN)/$(TARGET)

$(BIN)/$(TARGET) : $(OBJECT) 
	@echo "Linking..."
	$(CC) -o $@ $^
	@echo "Finished"

$(BIN)/%.o: $(SRC)/%.c
	@echo "Compiling... "
	$(call add_file_banner,$<)
	$(CC) $(CFLAGS) -c $< -o $@ 
#.PHONY : run clean help dost

run : $(BIN)/$(TARGET) 
	@echo "Running..."
	@./$(BIN)/$(TARGET)

clean:
	@rm -rf $(OBJECT) $(BIN)/$(TARGET)
	
help : 
	@echo "make (build with default cpp standard 17)"
	@echo "make clean"
	@echo "make run"
	@echo "make help"
	
##########################################################################################################################
# File Header Info
define add_file_banner
	@if grep -q " * File         : " $1; \
	then \
		sed -i 's/\( \* Date         : \).*/\1'"$(COMPILED_DATE)"'/' $1; \
	else \
		echo "/******************************************************************" > banner.tmp; \
		echo " * File         : $1" >> banner.tmp; \
		echo " * Description  :" >> banner.tmp; \
		echo " * Author       : $(AUTHOR_NAME)" >> banner.tmp; \
		echo " * Date         : $(COMPILED_DATE)" >> banner.tmp; \
		echo " ******************************************************************/" >> banner.tmp; \
		cat $1 >> banner.tmp; \
		mv banner.tmp $1; \
	fi
endef
