Cloudview::Application.routes.draw do
  controller :terminals do
    get '/terminals' => 'terminals#index'
  end
end
