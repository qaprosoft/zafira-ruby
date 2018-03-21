# frozen_string_literal: true

describe Zafira::Models::Job::Builder do
  let(:parsed_response) do
    {
      'id' => 1,
      'jobURL' => 'job-url',
      'jenkinsHost' => 'jenkins-host'
    }
  end

  let(:response) do
    OpenStruct.new(parsed_response: parsed_response, code: code)
  end

  let(:builder) { Zafira::Models::Job::Builder.new(response) }
  let(:job) { builder.construct }

  context 'zafira responses with 200 status' do
    let(:code) { 200 }

    describe 'job built and' do
      describe '#id' do
        it { expect(job.id).to eq(1) }
      end

      describe '#name' do
        it { expect(job.name).to eq(1) }
      end

      describe '#job_url' do
        it { expect(job.job_url).to eq('job-url') }
      end

      describe '#ci_host' do
        it { expect(job.ci_host).to eq('jenkins-host') }
      end
    end
  end

  context 'zafira responses with not 200 status' do
    let(:code) { 400 }

    it 'fails to init job' do
      expect(job).to eq(nil)
    end
  end
end
