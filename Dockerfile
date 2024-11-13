FROM ruby:3.2.2 as build
WORKDIR /app
# COPY Gemfile Gemfile.lock .
# ENV BUNDLER_WITHOUT development test
# RUN gem update --system && bundle install
ADD . .

FROM ruby:3.2.2
COPY --from=build /app /app
CMD ["ruby", "/app/exe/sampler.rb"]
