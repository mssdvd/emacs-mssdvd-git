.PHONY: build_install bootstrap clone prepare_dir clean

build_install:
	makepkg -sie

bootstrap: clone prepare_dir build_install

clone:
	git clone https://git.savannah.gnu.org/git/emacs.git emacs-master

prepare_dir:
	mkdir -p src
	ln -srf emacs-master src/emacs-master

clean:
	rm -rf pkg *.zst
