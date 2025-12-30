module ActiveAdminRole
  module Generators
    module Helper
      def self.included(klass)
        klass.extend ClassMethods
      end

      private

        def model_class_name
          options[:model] ? options[:model].classify : "AdminUser"
        end

        def model_file_path
          model_name.underscore
        end

        def model_path
          @model_path ||= File.join("app", "models", "#{model_file_path}.rb")
        end

        def namespace
          Rails::Generators.namespace if Rails::Generators.respond_to?(:namespace)
        end

        def namespaced?
          !!namespace
        end

        def model_name
          if namespaced?
            [namespace.to_s] + [model_class_name]
          else
            [model_class_name]
          end.join("::")
        end

        def inject_into_model
          indents = "  " * (namespaced? ? 2 : 1)
          inject_into_class model_path, model_class_name, "#{indents}role_based_authorizable\n"
        end

        def migration_class_name
          "ActiveRecord::Migration[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
        end

        module ClassMethods
          # Define the next_migration_number method (necessary for the migration_template method to work)
          def next_migration_number(dirname)
            next_migration_ts = Time.now.utc.strftime("%Y%m%d%H%M%S")

            if ActiveRecord.timestamped_migrations
              current = current_migration_number(dirname)
              if current.to_s >= next_migration_ts
                next_migration_ts = (current.to_i + 1).to_s
              end
              next_migration_ts
            else
              "%.3d" % (current_migration_number(dirname) + 1)
            end
          end
        end
    end
  end
end
