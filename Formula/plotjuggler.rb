class Plotjuggler < Formula
  desc "The Time Series Visualization Tool that you deserve."
  homepage "https://www.plotjuggler.io"
  license "MPL-2.0"

  head "https://github.com/facontidavide/PlotJuggler.git", branch: "main"

  stable do
    url "https://github.com/facontidavide/PlotJuggler/archive/refs/tags/3.8.10.tar.gz"
    sha256 "24a1bc5d860fb076539104efc55887b03aa89ca7eace0d815f31307f18722297"
  end

  depends_on "cmake" => :build
  depends_on "protobuf"
  depends_on "mosquitto"
  depends_on "qt@5"
  depends_on "zeromq"
  depends_on "zstd"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build", "--config", "RelWithDebInfo", "--target", "install"
  end


  test do
    system "#{bin}/plotjuggler", "--version"
  end
end
