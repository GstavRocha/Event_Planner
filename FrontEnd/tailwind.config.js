/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './src/**/*.{js,jsx,ts,tsx}'
  ],
  theme: {

    extend: {
      colors: {
        'oxford-blue': 'rgba(2, 17, 39, 1)',
        'purpureus': 'rgba(150, 73, 203, 1)',
        'pine-green': 'rgba(19, 111, 99, 1)'
      },
    },
  },
  plugins: [],
}

