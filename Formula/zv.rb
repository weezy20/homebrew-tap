class Zv < Formula
  desc "Ziglang Version Manager and Project Starter"
  homepage "https://github.com/weezy20/zv"
  url "https://github.com/weezy20/zv/releases/download/v0.12.0/zv-x86_64-apple-darwin.tar.gz"
  version "0.12.0"
  sha256 "bea538590abf04783e3559ccdd7df77d1ef20c4848baf5a409a3a79dec87e311"
  license "MIT"

  on_arm do
    url "https://github.com/weezy20/zv/releases/download/v0.12.0/zv-aarch64-apple-darwin.tar.gz"
    sha256 "485e5522c2a9cc6527952cb3774d047f394af43e2156efea77e35bcf62e39064"
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
