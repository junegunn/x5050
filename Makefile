all: x5050

xsize: src/xsize.cc
	/usr/bin/g++ -framework ApplicationServices $^ -o $@

x5050: src/x5050.template xsize
	cat $^ > $@
	chmod +x $@

clean:
	rm -fv xsize x5050

.PHONY: all clean
