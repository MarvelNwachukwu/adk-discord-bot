import { LlmAgent } from "@iqai/adk";
import { env } from "../../env";
import { getAdvancedAnalyticsTool, getMostTradedAgentTool, getTransactionHistoryTool, getTransactionMetricsTool, predictNextActionsTool } from "./atp-platform-tools";

export const getAtpAgent = () => {
  return new LlmAgent({
    name: "atp_agent",
    description: "An agent that can interact with the ATP and call tools to get tasks done on the Agent Trading Platform",
    model: env.LLM_MODEL,
    tools: [
      getMostTradedAgentTool,
      getTransactionHistoryTool,
      getTransactionMetricsTool,
      getAdvancedAnalyticsTool,
      predictNextActionsTool
    ],
  });
}

export default getAtpAgent;