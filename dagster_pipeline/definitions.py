from dagster import Definitions, ScheduleDefinition, define_asset_job, asset
from dagster_dbt import DbtCliResource, dbt_assets
from pathlib import Path
import sys
import os
sys.path.insert(0, os.path.dirname(__file__))
from assets import ingest_users, ingest_carts, ingest_products

# hardcoded path to dbt project
DBT_PROJECT_DIR = Path(__file__).parent.parent / "ecommerce_dbt"

# dbt resource
dbt_resource = DbtCliResource(project_dir=str(DBT_PROJECT_DIR))

# dbt assets
@dbt_assets(
    manifest=DBT_PROJECT_DIR / "target" / "manifest.json",
    dagster_dbt_translator=DagsterDbtTranslator()
)
def ecommerce_dbt_assets(context, dbt: DbtCliResource):
    yield from dbt.cli(
        ["run", "--profiles-dir", str(Path.home() / ".dbt")],
        context=context
    ).stream()

# job that runs everything
ecommerce_job = define_asset_job(
    name="ecommerce_pipeline_job",
    selection="*"
)

# daily schedule at 6am
daily_schedule = ScheduleDefinition(
    job=ecommerce_job,
    cron_schedule="0 6 * * *"
)

# main definitions
defs = Definitions(
    assets=[ingest_users, ingest_carts, ingest_products, ecommerce_dbt_assets],
    resources={"dbt": dbt_resource},
    schedules=[daily_schedule],
    jobs=[ecommerce_job]
)