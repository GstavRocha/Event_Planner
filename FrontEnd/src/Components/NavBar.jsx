import { useState } from 'react'

function NavBar() {

  return (
    <nav className="bg-gray-800 py-3 px-24 fixed w-full top-0 left-0">
      <div className="container mx-auto flex justify-between items-center ">

        <a href="#" className="text-white text-3xl font-bold">Event Planner</a>
        
        <div className="relative">
          <input type="text" className="bg-gray-700 text-white py-1 px-3 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Buscar..." />
          <button className="absolute inset-y-0 right-0 px-3 py-1 bg-blue-500  hover:bg-blue-700 font-bold  text-white rounded-md">Buscar</button>
        </div>
        
        <ul className="flex space-x-6">
          <li className="nav-item">
            <a href="#" className="text-white">Login</a>
          </li>
        </ul>
        
      </div>
    </nav>
  );


}

export default NavBar;
