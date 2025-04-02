--ユベル－Das Abscheulich Ritter
--Yubel - Terror Incarnate
function c4779091.initial_effect(c)
	c:EnableReviveLimit()
	--Cannot be destroyed by battle
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--You take no battle damage from battles involving this cards
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--Inflict damage to the opponent equal to the ATK of the monster that attacks this card
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc4779091(c4779091,0))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLE_CONFIRM)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCondition(c4779091.damcon)
	e3:SetTarget(c4779091.damtg)
	e3:SetOperation(c4779091.damop)
	c:RegisterEffect(e3)
	--Destroy all other monsters on the field
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc4779091(c4779091,1))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetCountLimit(1)
	e4:SetCondition(function(_,tp) return Duel.IsTurnPlayer(tp) end)
	e4:SetTarget(c4779091.destg)
	e4:SetOperation(c4779091.desop)
	c:RegisterEffect(e4)
	--Special Summon "Yubel - The Ultimate Nightmare"
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringc4779091(c4779091,2))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_LEAVE_FIELD)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e5:SetCondition(c4779091.spcon)
	e5:SetTarget(c4779091.sptg)
	e5:SetOperation(c4779091.spop)
	c:RegisterEffect(e5)
	--Cannot be Special Summoned
	local e6=Effect.CreateEffect(c)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e6)
end
c4779091.listed_names={CARD_YUBEL,31764700} --Yubel - The Ultimate Nightmare
local LOCATION_HAND_DECK_GRAVE=LOCATION_HAND|LOCATION_DECK|LOCATION_GRAVE
function c4779091.damcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttackTarget()
end
function c4779091.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAttackPos() end
	Duel.SetTargetPlayer(1-tp)
	local atk=Duel.GetAttacker():GetAttack()
	Duel.SetTargetParam(atk)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk)
end
function c4779091.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c4779091.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function c4779091.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	Duel.Destroy(g,REASON_EFFECT)
end
function c4779091.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP) and c:GetLocation()~=LOCATION_DECK
end
function c4779091.spfilter(c,e,tp)
	return c:IsCode(31764700) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c4779091.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c4779091.spfilter,tp,LOCATION_HAND_DECK_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND_DECK_GRAVE)
end
function c4779091.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c4779091.spfilter),tp,LOCATION_HAND_DECK_GRAVE,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
	end
end