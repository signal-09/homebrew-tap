class Iproute4mac < Formula
  include Language::Python::Virtualenv

  desc "CLI wrapper for iproute2 Linux routing utilities"
  homepage "https://pypi.org/project/iproute4mac/"
  url "https://pypi.io/packages/source/i/iproute4mac/iproute4mac-0.5.1.tar.gz"
  head "https://github.com/signal-09/iproute4mac.git", branch: "master"
  sha256 "d9864187d6ab268967ac978c6503e2cb72784f50f1aa3f5a26e1d14f9aa1d204"
  license "Apache-2.0"

  depends_on :macos
  depends_on "python@3.12"

  conflicts_with "iproute2mac", because: "both provide same executables"

  def install
    virtualenv_install_with_resources
  end

  test do
    output = shell_output("#{bin}/ip addr").strip
    assert_match "link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00", output
  end
end
