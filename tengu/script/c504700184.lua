--幻想召喚師
--Summoner of Illusions (GOAT)
--tributing monster is a cost
function c504700184.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc504700184(c504700184,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetCost(c504700184.cost)
	e1:SetTarget(c504700184.target)
	e1:SetOperation(c504700184.operation)
	c:RegisterEffect(e1)
end
function c504700184.rfilter(c,e,tp)
	return Duel.IsExistingMatchingCard(c504700184.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c)
end
function c504700184.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupCost(tp,c504700184.rfilter,1,false,nil,e:GetHandler(),e,tp) end
	local g=Duel.SelectReleaseGroupCost(tp,c504700184.rfilter,1,1,false,nil,e:GetHandler(),e,tp)
	Duel.Release(g,REASON_COST)
end
function c504700184.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c504700184.filter(c,e,tp,mc)
	return c:IsType(TYPE_FUSION) and Duel.GetLocationCountFromEx(tp,tp,mc,c)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c504700184.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c504700184.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if #sg>0 then
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCondition(c504700184.descon)
		e1:SetOperation(c504700184.desop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		sg:GetFirst():RegisterEffect(e1)
	end
end
function c504700184.descon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsHasEffect(66235877)
end
function c504700184.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end