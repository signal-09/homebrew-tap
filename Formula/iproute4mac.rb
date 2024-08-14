class Iproute4mac < Formula
  include Language::Python::Virtualenv

  desc "iproute for Mac"
  homepage "https://github.com/signal-09/iproute4mac"
  version "0.3.2"
  url "https://files.pythonhosted.org/packages/d1/28/faab9dbafd9ebced6582a6f71058b8e8e3ae2b0fed054ff61a5e3b9dfcdc/iproute4mac-0.3.2.tar.gz"
  sha256 "fae76d42d3f44f65fcc1347220527c0bc0fb2b768db269583481e366c22afcaa"
  head "https://github.com/signal-09/iproute4mac.git", branch: "master"

  depends_on :macos
  depends_on "python@3.12"

  conflicts_with "iproute2", "iproute2mac", because: "both provide same executables"

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/ip -Version"
  end
end
