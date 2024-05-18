import React, { useState } from 'react';


function Paginacao() {

  return (
    <div className="flex items-center justify-center m-8">
        <button href="#" className="flex items-center justify-center px-3 h-8 ms-0 leading-tight border rounded-s dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">
            <svg className="w-2.5 h-2.5 rtl:rotate-180" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 6 10">
                <path stroke="currentColor" strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M5 1 1 5l4 4"/>
            </svg>
        </button>

        {[1, 2, 3, 4, 5].map((page) => (
        <button key={page} href="#" className={`flex items-center justify-center px-3 h-8 leading-tight ${ page === 1 ? 'z-10 border hover:bg-roxo hover:text-white dark:border-gray-700 dark:bg-gray-700 dark:text-white' : 'text-gray-500 bg-white border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white'}`} aria-current={page === 3 ? 'page' : undefined}> 
        {page} 
        </button> 
        ))}

        <button href="#" className="flex items-center justify-center px-3 h-8 ms-0 leading-tight border rounded-r dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">
            <svg className="w-2.5 h-2.5 rtl:rotate-180" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 6 10">
                <path stroke="currentColor" strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="m1 9 4-4-4-4"/>
            </svg>
        </button>
    </div>
    );
};

export default Paginacao;
