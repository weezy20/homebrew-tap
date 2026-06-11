class Zv < Formula
  desc "Ziglang Version Manager and Project Starter"
  homepage "https://github.com/weezy20/zv"
  url "https://github.com/weezy20/zv/releases/download/v0.15.0/zv-x86_64-apple-darwin.tar.gz"
  version "0.15.0"
  sha256 "c4ffb18dca60618b615920b26e1253137fd1f6bd193011a87b30b97732952690"
  license "MIT"

  on_arm do
    url "https://github.com/weezy20/zv/releases/download/v0.15.0/zv-aarch64-apple-darwin.tar.gz"
    sha256 "10e0723de73a0aa467c393ae158cd34294ed925fec9130edd7c0bfb2e435fc8d"
  end

  def install
    mkdir_p libexec
    mv "zv", "\#{libexec}/zv"
    chmod 0755, "\#{libexec}/zv"
    mkdir_p bin
    ln_s "\#{libexec}/zv", "\#{bin}/zv"
  end

  def caveats
    <<~EOS
      zv is installed at \#{libexec}/zv with a symlink at \#{bin}/zv.

      Data directory: ~/.local/share/zv
      Run  to configure your shell environment.
    EOS
  end

  test do
    assert_match "zv", shell_output("\#{bin}/zv --version")
  end
end
