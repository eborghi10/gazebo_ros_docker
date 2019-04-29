# If you want to rebuild all images, set this to --no-cache from the commandline
DOCKER_ARGS?=

# You need to specify a particular target
#--------------------------------------------------------------------------
# Stable and local targets

.PHONY: dev_tools
dev_tools:
	docker build ${DOCKER_ARGS} -t dev_tools dev_tools

.PHONY: gz7_kinetic
gz7_kinetic: dev_tools
	docker build  ${DOCKER_ARGS} -t gz7_kinetic gz7_kinetic

.PHONY: gz9_crystal
gz9_crystal:
	docker build  ${DOCKER_ARGS} -t gz9_crystal gz9_crystal