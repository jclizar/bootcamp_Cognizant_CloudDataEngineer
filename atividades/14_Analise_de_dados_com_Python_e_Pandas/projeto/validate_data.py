import pandera as pa

def validate_data_df(df):
    schema = pa.DataFrameSchema(
        columns = {
            "data": pa.Column(pa.DateTime),
        }   
    )
    try:
        schema.validate(df)
        print("Formato de data validado")
    except BaseException as ex:
        print(f"Erro: {ex}")
        df["data"] = df["data"].astype("datetime64")
        print("Formato de data ajustado")
    return df