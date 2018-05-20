defmodule Contst.Types do
  @type transaction ::
          {:ok, any()}
          | {:error, any()}
          | {:error, Ecto.Multi.name(), any(), %{optional(Ecto.Multi.name()) => any()}}
end
