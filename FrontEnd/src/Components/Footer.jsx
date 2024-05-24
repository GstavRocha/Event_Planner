import { useState } from 'react'

// Corrigindo a função Footer para seguir o padrão de nomenclatura de componentes em React, começando com letra maiúscula
function Footer() {
  return (
  <footer className="fixed bottom-0 w-full rounded-lg shadow rounded-b-none dark:bg-gray-800">
      <div className="w-full max-w-screen-xl mx-auto p-4 md:flex md:items-center md:justify-between">
        <span class="text-sm text-gray-500 sm:text-left dark:text-gray-400">EVENT PLANNER internet soluções S.A <br/> © Copyright 2024
      </span>
      <ul class="flex flex-wrap items-center mt-3 text-sm font-medium text-gray-500 dark:text-gray-400 sm:mt-0">
          <li>
            <a href="https://github.com/GstavRocha/Event_Planner/blob/main/README.md" class="hover:underline me-4 md:me-6">SOBRE</a>
          </li>

          <li>
            <a href="Termos.pdf" download= "Termos.pdf" className="hover:underline me-4 md:me-6">TERMOS E POLÍTICAS</a>
          </li>
      </ul>
      </div>
  </footer>
   
   
  );
}

export default Footer;
