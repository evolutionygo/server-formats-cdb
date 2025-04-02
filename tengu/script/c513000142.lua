--リバイバルスライム (Anime)
--Revival Jam (Anime)
--Scripted by GameMaster (GM)
local s,c513000142,alias=GetID()
function c513000142.initial_effect(c)
	alias=c:GetOriginalCodeRule()
	--Revival
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc513000142(alias,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c513000142.spcon)
	e1:SetTarget(c513000142.sptg)
	e1:SetOperation(c513000142.spop)
	c:RegisterEffect(e1)
end
function c513000142.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetPreviousLocation()==LOCATION_MZONE and e:GetHandler():IsReason(REASON_DESTROY)
end
function c513000142.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c513000142.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end