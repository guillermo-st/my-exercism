defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts :: opts()) :: {:ok, opts()} | {:error, error()}
  @callback handle_frame(dot :: dot(), frame_number :: frame_number(), opts :: opts()) :: dot()

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end

end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, _opts) when rem(frame_number, 4) == 0, do: %{dot | opacity: dot.opacity/2}
  @impl DancingDots.Animation
  def handle_frame(dot, _frame_number, _opts), do: dot
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def init([]) do
    {:error, "The :velocity option is required, and its value must be a number. Got: nil"}
  end

  @impl DancingDots.Animation
  def init(opts = [velocity: velocity]) when is_number(velocity), do: {:ok, opts}

  @impl DancingDots.Animation
  def init(opts) do 
    {:error, "The :velocity option is required, and its value must be a number. Got: " <> ~s("#{Keyword.get(opts, :velocity)}")}
  end

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, opts) do
    velocity = Keyword.get(opts, :velocity)
    new_radius = dot.radius + velocity * (frame_number - 1)
    %{dot | radius: new_radius}
  end
end
