defmodule AoC2020.Day20.Part2 do
  import AoC2020.Day20.Parser

  alias __MODULE__, as: State

  defstruct [:side, :tiles, :ordered, :neighbors]

  @size 10
  @monster [
    {18, 0},
    {0, 1},
    {5, 1},
    {6, 1},
    {11, 1},
    {12, 1},
    {17, 1},
    {18, 1},
    {19, 1},
    {1, 2},
    {4, 2},
    {7, 2},
    {10, 2},
    {13, 2},
    {16, 2}
  ]
  @taken "#"

  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run(data) do
    tile_parser(data)
    |> to_state()
    |> order(0)
    |> to_map()
    |> orient()
    |> merge()
    |> find()
  end

  defp find(board) do
    monsters =
      board
      |> transformations()
      |> Enum.find_value(&find_monster/1)

    total =
      board
      |> Enum.map(fn r -> Enum.count(r, &(&1 == @taken)) end)
      |> Enum.sum()

    total - monsters * length(@monster)
  end

  defp find_monster(board) do
    count =
      board
      |> Enum.chunk_every(3, 1, :discard)
      |> Enum.map(&monsters_in_chunk/1)
      |> Enum.sum()

    if count > 0, do: count, else: false
  end

  def monsters_in_chunk(chunk) do
    chunk
    |> Enum.zip()
    |> Enum.chunk_every(20, 1, :discard)
    |> Enum.map(&chunk_to_map/1)
    |> Enum.count(&monster?/1)
  end

  def monster?(map) do
    @monster
    |> Enum.all?(fn pos -> Map.get(map, pos) == @taken end)
  end

  def chunk_to_map(chunk) do
    chunk
    |> Enum.with_index()
    |> Enum.reduce(%{}, &add_chunk_col/2)
  end

  defp add_chunk_col({{v0, v1, v2}, x}, map) do
    map
    |> Map.put({x, 0}, v0)
    |> Map.put({x, 1}, v1)
    |> Map.put({x, 2}, v2)
  end

  defp merge(tiles) do
    tiles
    |> Map.keys()
    |> Enum.sort_by(fn {x, y} -> {y, x} end)
    |> Enum.reduce([], &merge_tile(&1, &2, tiles))
    |> Enum.map(&Enum.reverse/1)
    |> Enum.map(&merge_row/1)
    |> Enum.reduce(&Enum.concat/2)
  end

  def merge_row(row) do
    row
    |> Enum.map(&Enum.with_index/1)
    |> List.flatten()
    |> Enum.group_by(fn {_, ind} -> ind end)
    |> Enum.map(fn {ind, tiles} -> {ind, tiles |> Enum.map(&elem(&1, 0))} end)
    |> Enum.sort()
    |> Enum.map(fn {_, tiles} -> List.flatten(tiles) end)
  end

  defp merge_tile({x, y}, merged, tiles) do
    [row | rows] = if x == 0, do: [[] | merged], else: merged
    tile = tiles |> Map.get({x, y}) |> strip
    [[tile | row] | rows]
  end

  def strip(tile) do
    tile
    |> tl()
    |> Enum.take(@size - 2)
    |> Enum.map(&tl/1)
    |> Enum.map(&Enum.take(&1, @size - 2))
  end

  defp to_state(tiles) do
    %State{
      ordered: [],
      tiles: tiles,
      neighbors: tiles |> Enum.into(%{}, fn {id, tile} -> {id, neighbors(tiles, tile)} end),
      side: tiles |> map_size |> :math.sqrt() |> trunc
    }
  end

  defp orient(tiles) do
    tiles
    |> Enum.map(&orient_tile(&1, tiles))
    |> Enum.into(%{})
  end

  defp orient_tile({pos, tile}, tiles) do
    {
      pos,
      tile
      |> transformations()
      |> Enum.find(&match_all_neighbors?(&1, tiles, pos))
    }
  end

  def match_all_neighbors?(tile, tiles, {x, y}) do
    [
      {hd(tile), {x, y - 1}},
      {Enum.at(tile, @size - 1), {x, y + 1}},
      {Enum.map(tile, &Enum.at(&1, 0)), {x - 1, y}},
      {Enum.map(tile, &Enum.at(&1, @size - 1)), {x + 1, y}}
    ]
    |> Enum.all?(fn {edge, pos} -> match_neighbor?(edge, Map.get(tiles, pos)) end)
  end

  def match_neighbor?(_, nil), do: true
  def match_neighbor?(edge, tile), do: edge in edges(tile)

  def transformations(tile) do
    turns = [
      tile,
      tile |> turn(),
      tile |> turn() |> turn(),
      tile |> turn() |> turn() |> turn()
    ]

    turns ++
      Enum.map(turns, &Enum.reverse/1) ++
      Enum.map(turns, fn t -> Enum.map(t, &Enum.reverse/1) end)
  end

  defp turn(tile) do
    tile
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.reverse/1)
  end

  defp order(state, ind) when ind == state.side * state.side, do: state

  defp order(state, ind) do
    candidates(ind, state)
    |> Enum.map(&order(%{state | ordered: [&1 | state.ordered]}, ind + 1))
    |> Enum.find(state, fn s -> length(s.ordered) == s.side * s.side end)
  end

  defp candidates(ind, state) do
    (Map.keys(state.tiles) -- state.ordered)
    |> Enum.filter(&(edge_count(ind, state.side) == state.neighbors[&1] |> length))
    |> Enum.filter(&match_neighbors?(ind, state, &1))
  end

  def to_map(state) do
    state.ordered
    |> Enum.chunk_every(state.side)
    |> Enum.with_index()
    |> Enum.reduce(%{}, &add_row(&1, &2, state))
  end

  defp add_row({row, y}, map, state) do
    row
    |> Enum.with_index()
    |> Enum.reduce(map, fn {id, x}, m -> Map.put(m, {x, y}, state.tiles[id]) end)
  end

  def edge_count(ind, size) when ind in [0, size - 1, size * size - 1, size * size - size], do: 2

  def edge_count(ind, size)
      when rem(ind, size) in [0, size - 1] or ind < size or ind > size * size - size,
      do: 3

  def edge_count(_, _), do: 4

  defp match_neighbors?(ind, state, id) do
    if(rem(ind, state.side) == 0, do: [state.side - 1], else: [0, state.side - 1])
    |> Enum.map(&Enum.at(state.ordered, &1))
    |> Enum.reject(&is_nil/1)
    |> Enum.all?(&(id in state.neighbors[&1]))
  end

  defp neighbors(tiles, tile) do
    tiles
    |> Enum.filter(&neighbors?(elem(&1, 1), tile))
    |> Enum.map(&elem(&1, 0))
  end

  defp neighbors?(tile1, tile2) do
    tile1 != tile2 && length(edges(tile1) -- edges(tile2)) < 8
  end

  defp tile_edges(tile) do
    [
      hd(tile),
      Enum.at(tile, @size - 1),
      Enum.map(tile, &Enum.at(&1, 0)),
      Enum.map(tile, &Enum.at(&1, @size - 1))
    ]
  end

  defp edges(tile) do
    main = tile_edges(tile)
    main ++ Enum.map(main, &Enum.reverse/1)
  end
end
