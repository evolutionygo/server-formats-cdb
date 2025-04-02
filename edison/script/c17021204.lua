--マザー・スパイダー
--Mother Spc17021204er
function c17021204.initial_effect(c)
	--spsummon proc
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c17021204.spcon)
	e1:SetTarget(c17021204.sptg)
	e1:SetOperation(c17021204.spop)
	c:RegisterEffect(e1)
end
function c17021204.spfilter(c)
	return c:IsPosition(POS_FACEUP_DEFENSE) and c:IsAbleToGraveAsCost()
end
function c17021204.cfilter(c)
	return c:GetRace()~=RACE_INSECT
end
function c17021204.check(tp)
	local g=Duel.GetMatchingGroup(Card.IsMonster,tp,LOCATION_GRAVE,0,nil)
	return #g~=0 and not g:IsExists(c17021204.cfilter,1,nil)
end
function c17021204.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local rg=Duel.GetMatchingGroup(c17021204.spfilter,tp,0,LOCATION_MZONE,nil)
	return aux.SelectUnselectGroup(rg,e,tp,2,2,aux.ChkfMMZ(1),0)
		and c17021204.check(c:GetControler())
end
function c17021204.sptg(e,tp,eg,ep,ev,re,r,rp,c)
	local rg=Duel.GetMatchingGroup(c17021204.spfilter,tp,0,LOCATION_MZONE,nil)
	local g=aux.SelectUnselectGroup(rg,e,tp,2,2,aux.ChkfMMZ(1),1,tp,HINTMSG_RELEASE,nil,nil,true)
	if #g>0 then
		g:KeepAlive()
		e:SetLabelObject(g)
		return true
	end
	return false
end
function c17021204.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	if not g then return end
	Duel.Release(g,REASON_COST)
	g:DeleteGroup()
end