=begin
module Mixin_metodo
  def method_missing(name, *params, &block)
    puts 4444
  end
end

class Class
  #include Mixin_metodo

  def method_missing(name, *params, &block)
    if name.to_s!= 'to_ary'
      self.singleton_class.send :include, Mixin_metodo
    end

  end

end
=end

class Hash

  attr_accessor :nuevos

  #TODO
  def method_missing_refactor(name, *params, &block)
    #self.define_singleton_method(name.to_sym, proc{"Metodo creado pero no implementado";return true})
    #self.singleton_class.send :alias_method, :maria, name.to_sym
    #self.nuevos << name.to_sym

    if (@nuevos==nil)
        @nuevos=Array.new
    end

    @nuevos << name.to_s

    self.define_singleton_method(name.to_sym, proc{"Metodo creado pero no implementado";return true})
    true

  end

end

class Class

  #@@version = 0
  #@@versionGral = 0
  #@@seVersiona = false
  #def version
   # @@version || 0
  #end

  #def versionar
   # @@version = @@version + 1
  #end
=begin
  class << self
    def version
      @@version || 0
    end
  end
=end

  def versionar(clase)
    clase.class_eval do
      def versionar
        @numeroVersion = self.version + 1
      end

      def version
        @numeroVersion || 0
      end

    end
  end

end

