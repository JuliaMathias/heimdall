defmodule Heimdall.PrivateData do
  defstruct [:uuid, :encrypted_text, :encryption_algo, :ttl_seconds]
  @crypt "AES256GCM"
  @type encryption_algo :: :aes | :aes_2
  @type t :: %__MODULE__{
          uuid: String.t(),
          encrypted_text: binary(),
          encryption_algo: encryption_algo(),
          ttl_seconds: integer()
        }

  @spec new(String.t(), String.t()) :: t
  def new(raw_text, key) do
    %__MODULE__{
      uuid: "tbd",
      encrypted_text: encrypt(raw_text, key),
      encryption_algo: :aes,
      ttl_seconds: 300
    }
  end

  defp encrypt(raw, key) do
    secret_key = :crypto.hash(:md5, key)
    initialization_vector = :crypto.strong_rand_bytes(16)

    {ciphertext, ciphertag} =
      :crypto.block_encrypt(
        :aes_gcm,
        secret_key,
        initialization_vector,
        {@crypt, raw, 16}
      )

    :base64.encode(initialization_vector <> ciphertag <> ciphertext)
  end
end
