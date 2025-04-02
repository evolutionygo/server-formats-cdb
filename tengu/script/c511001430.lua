--ＣＮｏ.１０３ 神葬零嬢ラグナ・インフィニティ (Anime)
--Number C103: Ragnafinity (Anime)
--Fixed by Larry126
Duel.EnableUnofficialProc(PROC_STATS_CHANGED)
Duel.LoadCardScript("c20785975.lua")
function c511001430.initial_effect(c)
	--Xyz Summon rocedure
	aux.AddXyzProcedure(c,nil,5,3)
	c:EnableReviveLimit()
	--Rank Up Check
	aux.EnableCheckRankUp(c,nil,nil,94380860)
	--Cannot be destroyed by battle, except with "Number" monsters
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(aux.NOT(aux.TargetBoolFunction(Card.IsSetCard,SET_NUMBER)))
	c:RegisterEffect(e1)
	--Inflict damage to your opponent
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511001430(c511001430,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(511001265)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511001430.damcon)
	e2:SetCost(aux.dxmcostgen(1,1,nil))
	e2:SetTarget(c511001430.damtg)
	e2:SetOperation(c511001430.damop)
	c:RegisterEffect(e2,false,REGISTER_FLAG_DETACH_XMAT)
	--Special Summon 1 "Number 103: Raganzero" from your GY
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc511001430(c511001430,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCondition(c511001430.spcon)
	e3:SetTarget(c511001430.sptg)
	e3:SetOperation(c511001430.spop)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_RANKUP_EFFECT)
	e4:SetLabelObject(e3)
	e4:SetLabel(RESET_EVENT|RESETS_STANDARD_EXC_GRAVE&(~RESET_REMOVE))
	c:RegisterEffect(e4)
end
c511001430.listed_series={SET_NUMBER}
c511001430.aux.xyz_number=103
c511001430.listed_names={94380860} --Number 103: Ragnazero
function c511001430.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_EFFECT) and c:IsPreviousLocation(LOCATION_MZONE)
end
function c511001430.spfilter(c,e,tp)
	return c:IsCode(94380860) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001430.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511001430.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511001430.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001430.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c511001430.damcon(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	if #eg~=1 then return false end
	local val=0
	if ec:GetFlagEffect(284)>0 then val=ec:GetFlagEffectLabel(284) end
	return ec:IsControler(1-tp) and ec:GetAttack()~=val and ec:IsLocation(LOCATION_MZONE)
end
function c511001430.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ec=eg:GetFirst()
	if chk==0 then return true end
	local dam=0
	local val=0
	if ec:GetFlagEffect(284)>0 then val=ec:GetFlagEffectLabel(284) end
	if ec:GetAttack()>val then dam=ec:GetAttack()-val
	else dam=val-ec:GetAttack() end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511001430.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end