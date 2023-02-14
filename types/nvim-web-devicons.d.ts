declare module 'nvim-web-devicons' {
    function get_icon(
        filename: string,
        extension: string,
        options?: { default?: boolean }
    ): LuaMultiReturn<[string, string]>;

    function get_icons(): Record<string, {
        color: string,
        icon: string,
    }>;
}
