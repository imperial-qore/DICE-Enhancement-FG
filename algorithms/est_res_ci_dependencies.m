function [resDataDep,sysDataDep] = est_ci_dependencies(metric)
% [resDataDep,sysDataDep] = EST_CI_DEPENDENCIES(data, resource, class)
% Returns data dependency matrix for est-ci

resDataDep = zeros(size(metric.ResData));
resourceIdx = find(cellfun(@(x) strcmp(metric.Resource,x),metric.ResList));
for r=1:length(metric.ResClassList)
    % require arrival timestamp for each class, except aggr
    resDataDep(hash_metric('arvT'),hash_data(metric,resourceIdx,r))=1;
    
    % require response time samples for each class, except aggr
    resDataDep(hash_metric('respT'),hash_data(metric,resourceIdx,r))=1;
end

sysDataDep = zeros(size(metric.SysData));

end