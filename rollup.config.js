// rollup.config.js

export default {
    input: '/main.js',
    output: {
        file: '/output.js',
        format: 'esm'
    },
    external: ['/main.js'],
    // ...
};