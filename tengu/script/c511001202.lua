--スピード・キング☆スカル・フレイム (Anime)
--Supersonic Skull Flame (Anime)
function c511001202.initial_effect(c)
	--Special Summon this card
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511001202.condition)
	e1:SetTarget(c511001202.target)
	e1:SetOperation(c511001202.operation)
	c:RegisterEffect(e1)
	--Special Summon 1 "Skull Flame" from your Graveyard
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511001202(c511001202,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c511001202.spcost)
	e2:SetTarget(c511001202.sptg)
	e2:SetOperation(c511001202.spop)
	c:RegisterEffect(e2)
	--Inflict 400 damage for each "Burning Skull Head" in your Graveyard
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc511001202(c511001202,1))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c511001202.damtg)
	e3:SetOperation(c511001202.damop)
	c:RegisterEffect(e3)
end
c511001202.listed_names={99899504,26293219}
function c511001202.cfilter(c,tp)
	return c:IsCode(99899504) and c:IsAbleToRemoveAsCost() and aux.SpElimFilter(c,true)
end
function c511001202.condition(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c511001202.cfilter,tp,LOCATION_GRAVE|LOCATION_MZONE,0,nil,tp)
	return aux.SelectUnselectGroup(g,e,tp,1,1,aux.ChkfMMZ(1),0)
end
function c511001202.target(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c511001202.cfilter,tp,LOCATION_GRAVE|LOCATION_MZONE,0,nil,tp)
	local rg=aux.SelectUnselectGroup(g,e,tp,1,1,aux.ChkfMMZ(1),1,tp,HINTMSG_REMOVE,nil,nil,true)
	if #rg>0 then
		rg:KeepAlive()
		e:SetLabelObject(rg)
		return true
	end
	return false
end
function c511001202.operation(e,tp,eg,ep,ev,re,r,rp,c)
	local rg=e:GetLabelObject()
	if not rg then return end
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
	rg:DeleteGroup()
end
function c511001202.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511001202.spfilter(c,e,tp)
	return c:IsCode(99899504) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001202.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMZoneCount(tp,e:GetHandler())>0
		and Duel.IsExistingMatchingCard(c511001202.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c511001202.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001202.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c511001202.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,26293219) end
	local dam=Duel.GetMatchingGroupCount(Card.IsCode,tp,LOCATION_GRAVE,0,nil,26293219)*400
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511001202.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local d=Duel.GetMatchingGroupCount(Card.IsCode,tp,LOCATION_GRAVE,0,nil,26293219)*400
	Duel.Damage(p,d,REASON_EFFECT)
end