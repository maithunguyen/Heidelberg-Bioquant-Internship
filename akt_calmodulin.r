# Set rng seed for debugging tests
#set.seed(1)

# Simulation Parameters (Vector)
sim_params <- c(timestep = 0.1,
                endTime = 1200)
# Model Parameters (List)
model_params <- list(vols      = c(vol = 5e-14),
                     init_conc = c(Prot_inact = 100,
                                   Prot_act = 0))

# Read Ca timeseries
input_df <- read.table("C:/Users/Mai Thu Nguyen/Desktop/copasi/Copasi output/1200t_h1h2.txt", col.names = c("time", "Ca"))

input_df["Ca"] <- input_df["Ca"]*1e6*100

# Simulate model
output <- sim_calmodulin(input_df, sim_params, model_params)
output <- as.data.frame(output)

# Plot output
colnames(output) <- c("time", "calcium", "Prot_inact", "Prot_act")
plot(output$time, output$calcium, xlim = c(0,1200), ylim = c(0,100), col="blue", type="l", xlab="Time [s]", ylab="Concentration [nM]")
lines(output$time, output$Prot_act, col="red", type="l")
lines(output$time, output$Prot_inact, col="black", type="l")
legend("topright", legend=c("calcium", "calmodulin_act", "Calmodulin_inact"), col=c("blue", "red", "black"), lty=c(1,1))
