require 'rspec'
require '../src/meta-parcial'

describe 'Practica-Parcial' do

  it 'ejecutar cualquier metodo sin parametros en Hash clase y que lo acepte con un warning que falta implementacion' do

    a=Hash.new
    a.metodo_implementacion.should==true
    #a.maria==true
    #a.nuevos.size.should==2
    #a.metodo_implementacion2.should==true

  end

  it 'ejecutar cualquier metodo sin parametros en cualquier clase y que lo acepte con un warning que falta implementacion' do

    #a=Array.new
    #a.metodo_implementacion_general.should==true

  end

  it 'Version de objetos' do

    a=Array.new
    Class.versionar Array
    a.versionar
    a.version.should==1
    #a.versionGral.should==1

    a.versionar
    a.version.should==2

    b=Array.new
    b.versionar
    b.version.should==1

    c=Hash.new
    Class.versionar Hash
    c.versionar
    c.version.should==1

  end

end