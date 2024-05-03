import { useState } from 'react'

function NavBar() {
  /* const [count, setCount] = useState(0) */

  /* return (
    <div>
      <h1 class="text-center">Event Planner</h1>
    </div>
  ) */

  return (
    <nav class="bg-gray-800 py-3 px-24 fixed w-full top-0 left-0">
      <div class="container mx-auto flex justify-between items-center ">

        <a href="#" class="text-white text-3xl font-bold">Event Planner</a>
        
        <div class="relative">
          <input type="text" class="bg-gray-700 text-white py-1 px-3 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Buscar..." />
          <button class="absolute inset-y-0 right-0 px-3 py-1 bg-blue-500  hover:bg-blue-700 font-bold  text-white rounded-md">Buscar</button>
        </div>
        
        <ul class="flex space-x-6">
          <li class="nav-item">
            <a href="#" class="text-white">Login</a>
          </li>
        </ul>
        
      </div>
    </nav>
  );


}

export default NavBar;
