# frozen_string_literal: true

describe Zafira::Operations::ZafiraClient::ValidateHandlers do
  let(:client) do
    build(:zafira_client, :with_environment, :rspec)
  end

  let(:validator) do
    Zafira::Operations::ZafiraClient::ValidateHandlers.new(client)
  end

  before do
    expect(client).to receive(:disabled?).and_return(false)
  end

  before do
    logger_mock = double('validator.logger').as_null_object
    allow(validator).to receive(:logger).and_return(logger_mock)
  end

  describe '#call' do
    context 'passed because all handlers implemented methods' do
      describe '#dammed?' do
        it do
          expect(validator.call.dammed?).to eq(false)
        end
      end
    end

    describe '#test_case_handler_class' do
      context 'dammed because' do
        context 'handler is nil' do
          before do
            expect(client).to receive(:test_case_handler_class)
          end

          describe '#error_pool' do
            it do
              expect(validator.call.dammed?).to eq(true)
              expect(validator.error_pool).to eq(
                '`test_case_handler_class` must be set in your config file'
              )
            end
          end
        end

        context 'methods are not implemented' do
          describe '#test_class' do
            before do
              instance_methods =
                client.test_case_handler_class.instance_methods - [:test_class]

              expect(client.test_case_handler_class).to(
                receive(:instance_methods).and_return(instance_methods)
              )
            end

            describe '#error_pool' do
              it do
                expect(validator.call.dammed?).to eq(true)
                expect(validator.error_pool).to eq(
                  '`test_case_handler_class` - method(s) [:test_class] must ' \
                  'be implemented in handler class'
                )
              end
            end
          end

          describe '#test_method' do
            before do
              instance_methods =
                client.test_case_handler_class.instance_methods - [:test_method]

              expect(client.test_case_handler_class).to(
                receive(:instance_methods).and_return(instance_methods)
              )
            end

            describe '#error_pool' do
              it do
                expect(validator.call.dammed?).to eq(true)
                expect(validator.error_pool).to eq(
                  '`test_case_handler_class` - method(s) [:test_method] must ' \
                  'be implemented in handler class'
                )
              end
            end
          end

          describe '#info' do
            before do
              instance_methods =
                client.test_case_handler_class.instance_methods - [:info]

              expect(client.test_case_handler_class).to(
                receive(:instance_methods).and_return(instance_methods)
              )
            end

            describe '#error_pool' do
              it do
                expect(validator.call.dammed?).to eq(true)
                expect(validator.error_pool).to eq(
                  '`test_case_handler_class` - method(s) [:info] must ' \
                  'be implemented in handler class'
                )
              end
            end

            describe 'and #test_method' do
              before do
                instance_methods =
                  client.test_case_handler_class.instance_methods -
                  %i[info test_method]

                expect(client.test_case_handler_class).to(
                  receive(:instance_methods).and_return(instance_methods)
                )
              end

              describe '#error_pool' do
                it do
                  expect(validator.call.dammed?).to eq(true)
                  expect(validator.error_pool).to eq(
                    '`test_case_handler_class` - method(s) ' \
                    '[:test_method, :info] must be implemented ' \
                    'in handler class'
                  )
                end
              end
            end
          end
        end
      end
    end
  end
end
