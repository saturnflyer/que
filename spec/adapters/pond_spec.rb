require 'spec_helper'

describe "Que using Pond" do
  it_behaves_like "a Que pool"

  it "should be able to tell when it's already in a transaction" do
    Que.pool.should_not be_in_transaction
    QUE_SPEC_POND.checkout do |conn|
      conn.async_exec "BEGIN"
      Que.pool.should be_in_transaction
      conn.async_exec "COMMIT"
    end
  end
end
