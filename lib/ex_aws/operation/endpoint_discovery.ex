defmodule ExAws.Operation.EndpointDiscovery do
  @moduledoc false

  defstruct service: nil,
            request_operation: nil,
            endpoint_operation: nil

  @type t :: %__MODULE__{}

  def new(service, opts) do
    struct(%__MODULE__{service: service}, opts)
  end
end

defimpl ExAws.Operation, for: ExAws.Operation.EndpointDiscovery do
  @type response_t :: %{} | ExAws.Request.error_t()

  def perform(operation, config) do
    handle_endpoint_operation(operation, config)
    |> handle_request_operation(operation, config)
  end

  def stream!(_, _) do
    raise ArgumentError, """
    This operation does not support streaming!
    """
  end

  defp handle_endpoint_operation(%{endpoint_operation: nil} = _op, _config), do: nil

  defp handle_endpoint_operation(%{endpoint_operation: endpoint_operation} = _op, config) do
    {:ok, %{"Endpoints" => endpoints}} =
      endpoint_operation
      |> ExAws.request(config)

    endpoints
    |> Enum.random()
    |> Map.fetch!("Address")
  end

  defp handle_request_operation(_endpoint_host, %{request_operation: nil}, _config), do: nil

  defp handle_request_operation(
         endpoint_host,
         %{request_operation: request_operation} = _op,
         config
       ) do
    config = Map.replace!(config, :host, endpoint_host)

    request_operation
    |> ExAws.request(config)
  end
end
