--Puppet King
function c511002732.initial_effect(c)
	--summon with 1 tribute
	local e1=aux.AddNormalSummonProcedure(c,true,true,1,1,SUMMON_TYPE_TRIBUTE,aux.Stringc511002732(c511002732,0),c511002732.otfilter)
end
c511002732.listed_names={511002731}
function c511002732.otfilter(c,tp)
	return c:IsCode(511002731) and (c:IsControler(tp) or c:IsFaceup())
end