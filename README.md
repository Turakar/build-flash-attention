# Build FlashAttention

1. Install [uv](https://docs.astral.sh/uv/).
2. Run `./build.sh`.
3. Run `./build.sh --flash-attn3` for FlashAttention 3.

Compilation is very memory hungry and can be quite long (a few hours on an GH200).
The default number of compilation jobs is set to 16 in `build.sh`.
