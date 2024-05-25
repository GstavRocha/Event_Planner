function Login() {
    
    return(
        <>
            <section className=" bg-gray-50 dark:bg-oxford-blue">
            <div class="flex flex-col items-center justify-center px-6 py-8 mx-auto md:h-screen lg:py-0">
                {/*<a href="#" class="flex items-center mb-6 text-2xl font-semibold text-gray-900 dark:text-white">
                    {/*<img class="w-8 h-8 mr-2" src="https://flowbite.s3.amazonaws.com/blocks/marketing-ui/logo.svg" alt="logo"/>
                        Event Planner  </a>*/}
            <div class="w-full bg-white rounded-lg shadow dark:border md:mt-0 inset-x-2 sm:max-w-md xl:p-0 dark:bg-oxford-blue dark:border-transparent">
                <div class=" p-6 space-y-4 md:space-y-6 sm:p-8">
                    <h1 class= "text-center text-xl font-bold leading-tight tracking-tight text-gray-900  dark:text-white"> Faça seu login! </h1>
                    <form class="justify-endspace-y-4 md:space-y-6" action="#">
                        <div>
                            <label for="email" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">E-mail</label>
                            <input type="email" name="email" id="email"  placeholder="name@email.com" class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-2 focus:ring-primary-600 focus:border-primary-600 focus:shadow-roxo-sm block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-roxo" required=""/>
                        </div>
                        <div>
                            <label for="password" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Senha</label>
                            <input type="password" name="password" id="password" placeholder="••••••••" class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-2 focus:ring-primary-600 focus:border-primary-600 focus:shadow-roxo-sm block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-roxo" required=""/>
                        </div>
                        <div class="flex items-center justify-between">
                            <div class="flex items-start">
                                <div class="flex items-center h-5">
                                    <input id="remember" aria-describedby="remember" type="checkbox" class="w-4 h-4 border border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:bg-gray-700 dark:border-gray-600 dark:focus:ring-primary-600 dark:ring-offset-gray-800" required=""/>
                                </div>
                                <div class="ml-3 text-sm">
                                    <label for="remember" class="text-gray-500 dark:text-gray-300">Lembrar de mim</label>
                                </div>
                            </div>
                            <a href="#" class="text-sm font-medium text-primary-600 hover:underline dark:text-white">Esqueceu a senha?</a>
                        </div>
                        <button type="submit" class="w-full text-white bg-pine-green hover:bg-primary-700 focus:ring-4 focus:outline-none focus:ring-primary-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-primary-60 dark:hover:bg-primary-700 dark:focus:ring-primary-800">Entrar</button>
                        
                        <p class="text-sm font-light text-gray-500 dark:text-gray-400">
                        Já possui uma conta? <a href="#" class="font-medium text-primary-600 hover:underline dark:text-primary-500">Faça login!</a>
                        </p>
                    </form>
                </div>
            </div>
        </div>
        </section>
        </>
    );
}

export default Login;