--救世竜 セイヴァー・ドラゴン
function c21159309.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetValue(c21159309.synlimit)
	c:RegisterEffect(e1)
end
c21159309.listed_series={0x3f}
function c21159309.synlimit(e,c)
	if not c then return false end
	return not c:IsSetCard(0x3f)
end