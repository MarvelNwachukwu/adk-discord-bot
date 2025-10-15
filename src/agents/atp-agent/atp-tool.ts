import { McpAtp } from "@iqai/adk";
import { env } from "../../env";

const atpTool = McpAtp({
	env: {
		WALLET_PRIVATE_KEY: env.WALLET_PRIVATE_KEY,
    ATP_API_KEY: env.ATP_API_KEY,
	},
});

export const tools = atpTool.getTools();
