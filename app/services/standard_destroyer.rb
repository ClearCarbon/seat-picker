class StandardDestroyer < Struct.new(:listener)
  def destroy(record)
    if record.destroy
      listener.success(record)
    else
      listener.failure(record)
    end
  end
end
