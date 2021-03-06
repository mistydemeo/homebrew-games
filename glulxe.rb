require 'formula'

class Glulxe < Formula
  homepage 'http://www.eblong.com/zarf/glulx/'
  url 'http://eblong.com/zarf/glulx/glulxe-052.tar.gz'
  version '0.5.2'
  sha1 '492b501dc297e8e03273e1fdaa2e8e7aaee2b899'
  head 'https://github.com/erkyrath/glulxe.git'

  # http://www.eblong.com/zarf/glk/index.html
  resource 'glkterm' do
    url 'http://www.eblong.com/zarf/glk/glkterm-104.tar.gz'
    version '1.0.4'
    sha1 'cf67bc8f93e6c71898f59e8083fc65622ed02d54'
  end

  def install
    glkterm_lib = libexec+'glkterm/lib'
    glkterm_include = libexec+'glkterm/include'

    resource('glkterm').stage do
      system 'make'
      glkterm_lib.install 'libglkterm.a'
      glkterm_include.install 'glk.h', 'glkstart.h', 'gi_blorb.h', 'gi_dispa.h', 'Make.glkterm'
    end

    inreplace 'Makefile', 'GLKINCLUDEDIR = ../cheapglk', "GLKINCLUDEDIR = #{glkterm_include}"
    inreplace 'Makefile', 'GLKLIBDIR = ../cheapglk', "GLKLIBDIR = #{glkterm_lib}"
    inreplace 'Makefile', 'Make.cheapglk', 'Make.glkterm'

    system 'make'
    bin.install 'glulxe'
  end
end
