defmodule Cookery.TestHelpers do

  def read_stub do
    {:ok, data} = File.read("test/fixtures/search_peanuts.json")
    data
  end

  def call_bypass(bypass) do
    Bypass.expect bypass, "GET", "/search", fn conn ->
      Plug.Conn.resp(conn, 200, read_stub() )
    end
  end

end