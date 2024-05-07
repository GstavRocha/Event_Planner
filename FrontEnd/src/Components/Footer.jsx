import { useState } from 'react'

// Corrigindo a função Footer para seguir o padrão de nomenclatura de componentes em React, começando com letra maiúscula
function Footer() {
  return (
    <footer className="footer footer-center p-10 bg-gray-800 text-white rounded flex flex-col items-center">
      <div className="flex flex-row">
        <nav className='p-10 mr-10'>
          <h6 className="footer-title font-bold text-lg">SIGA-NOS</h6> 
          <a href="#">Github</a><br/>
        </nav> 

        <nav className='p-10 mr-10'> 
          <h6 className="footer-title font-bold text-lg">SOBRE</h6>
          <a href="#">Contato</a><br/>
        </nav> 

        <nav className='p-10 mr-10'> 
          <h6 className="footer-title font-bold text-lg">LEGAL</h6> 
          <a href="#">Termos de uso</a><br/>
          <a href="#">Politica e privacidade</a><br/>
          <a href="#">Politica de cookies</a>
        </nav>
      </div>
      <div className="footer px-10 py-4 border-t bg-base-200 text-base-content w-full border-base-300">
        <aside className="items-center grid-flow-col">
          <p>EVENT PLANNER internet soluções S.A <br/>© Copyright 2024</p>
        </aside> 
      </div>

      <nav className="md:place-self-center md:justify-self-end ">
        <div className="grid grid-flow-col gap-4">
          {/*Substituir imagem svg clicavel:*/}
          <img src="/IconGithub.svg" alt="Ícone de Github" className="relative right-0 h-10 w-8" /><br/>
          <img src="/iconInstagram.svg" alt="Ícone de Instagram" className="relative right-2 h-10 w-8"/>
          <img src="/IconFacebok.svg" alt="Ícone de Facebook" className="relative right-0 h-10 w-8" />
        </div>
      </nav>
    </footer>
  );
}

export default Footer;
