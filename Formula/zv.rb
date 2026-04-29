class Zv < Formula
  desc "Ziglang Version Manager and Project Starter"
  homepage "https://github.com/weezy20/zv"
  url "https://github.com/weezy20/zv/releases/download/v0.13.0/zv-x86_64-apple-darwin.tar.gz"
  version "0.13.0"
  sha256 "ed9549f76c2d274c5d5f60c6ba6854e7f526ce75053fb3d3baaf58aabe25e255"
  license "MIT"

  on_arm do
    url "https://github.com/weezy20/zv/releases/download/v0.13.0/zv-aarch64-apple-darwin.tar.gz"
    sha256 "af719d7c3cc0402b8a50f1132afb74feb57c38277aa4dcc649f84b2d6cb51214"
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
