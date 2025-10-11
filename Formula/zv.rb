class Zv < Formula
  desc "Ziglang Version Manager and Project Starter"
  homepage "https://github.com/weezy20/zv"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/weezy20/zv/releases/download/v0.5.0/zv-aarch64-apple-darwin.tar.gz"
      sha256 "78cdb859f636c07fa10ff5644753070871304403d9e26d304a6f222e491f3771"
    end
    if Hardware::CPU.intel?
      url "https://github.com/weezy20/zv/releases/download/v0.5.0/zv-x86_64-apple-darwin.tar.gz"
      sha256 "8b6e3005d3672da63d94d67c4e20ccaf201766d678db2e45bf362e5f4c706461"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/weezy20/zv/releases/download/v0.5.0/zv-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "45e1cc94f5d21f311d66420cf1d1bed6e61ea40e45d26184a69dae3472adf1f2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/weezy20/zv/releases/download/v0.5.0/zv-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6ccb992c2cc86d7d1aa8a7edb0312a6c9c5b49033d81b0c71f0b03eca1e8afc9"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "zv" if OS.mac? && Hardware::CPU.arm?
    bin.install "zv" if OS.mac? && Hardware::CPU.intel?
    bin.install "zv" if OS.linux? && Hardware::CPU.arm?
    bin.install "zv" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
