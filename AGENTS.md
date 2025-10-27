# Repository Guidelines

## Project Structure & Module Organization
Rails 8 on Ruby 3.3.2 with MySQL. `app/` holds domain code: `components/` (ViewComponent), `policies/` (Pundit), and `javascript/controllers/` (Stimulus `*_controller.js`). Global settings live in `config/` with secrets encrypted via `config/master.key`. Migrations reside in `db/migrate`, seeds in `db/seeds.rb`, and schema snapshots alongside them. Tests stay under `test/` (models, controllers, system, components) with fixtures in `test/fixtures` and FactoryBot blueprints in `test/factories`.

## Build, Test, and Development Commands
Run `bin/setup` once to install gems, configure MySQL, and sync JavaScript assets. `bin/dev` runs the Rails server plus the Tailwind watcher; use `bin/docker-develop` for container parity. Prepare databases via `bin/rails db:prepare` before `bin/rails test` or `bin/rails test:system`. Keep CI green by running `bin/rubocop`, `bin/brakeman --no-pager`, and `bin/importmap audit` locally.

## Coding Style & Naming Conventions
Rubocop Rails Omakase is the source of truth: two-space indent, single quotes unless interpolating, and trailing commas on multiline literals. Ruby stays `snake_case`; classes and modules use `CamelCase`; migrations follow `YYYYMMDDHHMMSS_action_on_table.rb`. Match Stimulus controllers to `data-controller` attributes and extract reusable UI into `app/components`.

## Testing Guidelines
Minitest drives the suite. Add unit coverage beside code (`test/models/..._test.rb`) and browser flows in `test/system` with Capybara. Use fixtures for canonical data and FactoryBot for variations. Run `bin/rails test` before every push and add `bin/rails test:system` when touching UI to catch Chrome-driven regressions. Stub external calls and lean on shared helpers under `test/` to keep runs deterministic.

## Commit & Pull Request Guidelines
Write imperative, present-tense commits (`Add booking impersonation guard`) with focused scopes. Pull requests should explain the change, note manual checks, and link the tracking issue. Include screenshots for UI updates, call out migrations or feature flags, and confirm `bin/brakeman`, `bin/importmap audit`, `bin/rubocop`, and `bin/rails test` succeed locally before requesting review.

## Security & Configuration Tips
Store API keys in encrypted credentials; never commit `.env`. Sentry and Lograge ship by default—tag new controllers or jobs with useful context. Wire Pundit authorization into new endpoints and document required roles in the PR. Share `config/master.key` securely.
